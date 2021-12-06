/*******************************************************************************
 * 
 * Created by Daniel Carrasco at https://www.electrosoftcloud.com
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 ******************************************************************************/

#include "streams/rzip_stream.h"
#include <fstream>

int main(int argc, char* argv[]) {
    // Check if two arguments were provided
    if (argc != 3) {
        fprintf(
            stderr,
            "\n\nWrong number of arguments (%d):\n"
            "   Example:\n"
            "       %s input.srm output.sav\n"
            "       %s input.sav output.srm\n\n\n",
            argc,
            argv[0],
            argv[0]
        );
        return 1;
    }

    void *data;
    bool compress = false;
    std::string input_file = argv[1];
    std::string output_file = argv[2];

    char dummy;
    // Open input file
    std::ifstream input;
    input.open(input_file, std::ios_base::in|std::ios_base::binary);
    if (!input.read(&dummy, 0)) {
        fprintf(stderr, "\nThere was an error opening the source file (maybe it doesn't exists)\n\n");
        return 1;
    }

    // Open output file
    std::fstream output;
    output.open(output_file, std::ios_base::in|std::ios_base::binary);
    if (output.read(&dummy, 0)) {
        fprintf(stderr, "\nThe destination file already exists. Delete it first to continue.\n\n");
        input.close();
        return 1;
    }
    output.close();
    output.open(output_file, std::ios_base::out|std::ios_base::binary);
    if (!output.good()) {
        fprintf(stderr, "ERROR: output file cannot be opened for write.\n");
        input.close();
        return 1;
    }

    char header[5];
    if (!input.read(header, 5)) {
        fprintf(stderr, "\nThere was an error reading the input file\n\n");
        input.close();
        output.close();
        return 1;
    }

    if (
        header[0] == '#' &&
        header[1] == 'R' &&
        header[2] == 'Z' &&
        header[3] == 'I' &&
        header[4] == 'P'
    ) {
        printf("Decompressing the input file...\n");
        compress = false;
    }
    else {
        printf("Compressing the input file...\n");
        compress = true;
    }

    if (compress) {
        output.close();
        input.seekg(0, std::ios_base::end);
        int64_t data_size = input.tellg();
        input.seekg(0, std::ios_base::beg);

        if (data_size < 1) {
            fprintf(stderr, "\nThere was an error reading the input file.\n\n");
            input.close();
            return 1;
        }

        data = malloc(data_size);
        if (!data) {
            fprintf(stderr, "\nMemory error...\n\n");
            return 1;
        }
        input.read(reinterpret_cast<char*>(data), data_size);

        if (rzipstream_write_file(output_file.c_str(), data, data_size)) {
            fprintf(stdout, "The file was compressed sucessfully\n");
            input.close();
            if (data) {
                free(data);
            }
            return 0;
        }
        else {
            fprintf(stderr, "There was an error compressing the file\n");
            output.close();
            if (data) {
                free(data);
            }
            return 1;
        }
    }
    else {
        int64_t extracted = 0;
        // For now the srm library opens the input file, so is not required anymore
        input.close();

        if (rzipstream_read_file(input_file.c_str(), &data, &extracted)) {
            output.write(reinterpret_cast<char*>(data), extracted);
            if (!output.fail()){
                fprintf(stdout, "The file was decompressed sucessfully\n");
                output.close();
                if (data) {
                    free(data);
                }
                return 0;
            }
            else {
                fprintf(stderr, "There was an error writting the output file\n");
                output.close();
                if (data) {
                    free(data);
                }
                return 1;
            }
            
        }
        else {
            fprintf(stderr, "There was an error extracting the file\n");
            output.close();
            if (data) {
                free(data);
            }
            return 1;
        }
    } 
}