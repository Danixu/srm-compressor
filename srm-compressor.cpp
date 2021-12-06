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

int main() {
    void *data;
    int64_t extracted = 0;

    if (rzipstream_read_file("Tekken 3.srm", &data, &extracted)) {
        std::ofstream output;
        output.open("Tekken 3.srm.dec");

        output.write((char*)data, extracted);
        output.close();
        if (!output.fail()){
            fprintf(stdout, "Everything was OK\n");
            return 0;
        }
        else {
            fprintf(stderr, "There was an error writting the output file\n");
            return 1;
        }
        
    }
    else {
        fprintf(stderr, "There was an error extracting the file\n");
        return 1;
    }
}