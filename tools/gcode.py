import math
import re


def parse(line):
    """
    Parse single gcode line
    """

    line_parts = line.split(';')

    parsed_line = {
        'input_line': line
    }

    if len(line_parts) > 1:
        parsed_line["comment"] = line_parts[1].strip()

    if len(line_parts[0].strip()) > 0:
        parsed_line["full_command"] = line_parts[0].strip()

        parsed_command = parsed_line["full_command"].split(' ')
        parsed_line['command'] = parsed_command[0]

        if len(parsed_command) > 1:
            params = {}
            parsed_line['params'] = params
            for param in parsed_command[1:]:
                if param[0] in ('X', 'Y', 'Z', 'E'):
                    # convert to float
                    params[param[0]] = float(param[1:])
                else:
                    params[param[0]] = param[1:]

    return parsed_line


def parse_gcode(gcode):
    """
    Parse gcode from a multiline string
    """
    # Split to lines
    lines = gcode.split('\n')
    # Parse lines
    return [parse(line) for line in lines ]


def dist(dx, dy, dz):
    return math.sqrt(dx ** 2 + dy ** 2 + dz ** 2)


def calc_volumetric_info(gcode, req_volume=None):
    """
    Prints distance and volumetric information between two consecutive points in print head move
    """

    current_pos = {
        'X': None,
        'Y': None,
        'Z': None
    }

    for cmd in gcode:
        if "command" in cmd and cmd["command"] in ('G0', 'G1'):
            dx, dy, dz = 0, 0, 0
            new_pos = current_pos.copy()

            if 'X' in cmd['params'].keys():
                new_pos['X'] = cmd['params']['X']
                if current_pos['X']:
                    dx = abs(current_pos['X'] - new_pos['X'])

            if 'Y' in cmd['params'].keys():
                new_pos['Y'] = cmd['params']['Y']
                if current_pos['Y']:
                    dy = abs(current_pos['Y'] - new_pos['Y'])

            if 'Z' in cmd['params'].keys():
                new_pos['Z'] = cmd['params']['Z']
                if current_pos['Z']:
                    dz = abs(current_pos['Z'] - new_pos['Z'])

            d = dist(dx, dy, dz)

            cmd['calculated'] = calculated = {
                'dist': d
            }

            if 'E' in cmd['params'].keys() and d > 0:
                calculated['volume'] = cmd['params']['E']/d

            if req_volume and d > 0:
                calculated['E'] = d * req_volume

            current_pos = new_pos


def print_volumetric_info(gcode, req_volume=None):
    calc_volumetric_info(gcode, req_volume)
    for cmd in gcode:
        print(cmd['full_command'])

        calculated = cmd["calculated"]
        if calculated:
            print("  dist        : {}".format(calculated['dist']))
            print("  volume      : {}".format(calculated.get('volume', '--')))
            print("  suggested E : {}".format(calculated.get('E', '--')))


def recalc_e(gcode, req_volume):
    calc_volumetric_info(gcode, req_volume)
    for cmd in gcode:

        if "calculated" in cmd and 'E' in cmd["calculated"]:
            print(re.sub(' E[\d\-.]+', ' E{:1.5f}'.format(cmd["calculated"]['E']), cmd['input_line']))
        else:
            print(cmd['input_line'])


gcode = '''

G1 F1200

G1 X207.143 Y92.961 Z3.280 E0.5; move to next layer (15)
G1 X24.468 Y92.961 E16.42248 ; perimeter

G1 X24.568 Y83.735 E0.82947  ; perimeter
G1 X25.633 Y83.735 E0.09574  ; perimeter
G1 X25.633 Y90.837 E0.63847  ; perimeter
G1 X206.078 Y90.837 E16.22201 ; perimeter
G1 X206.078 Y83.735 E0.63847 ; perimeter
G1 X207.143 Y83.735 E0.09574 ; perimeter


G1 X207.143 Y92.793 Z3.480 E0.81451;  move to next layer (16)
G1 X24.468 Y92.793 E16.42248 ; perimeter

G1 X24.568 Y83.735 E0.81436  ; perimeter
G1 X25.633 Y83.735 E0.09574  ; perimeter
G1 X25.633 Y90.837 E0.63847  ; perimeter
G1 X206.078 Y90.837 E16.22201 ; perimeter
G1 X206.078 Y83.735 E0.63847 ; perimeter
G1 X207.143 Y83.735 E0.09574 ; perimeter





G1 X207.143 Y92.625 Z3.680 E0.79941; move to next layer (17)
G1 X24.468 Y92.625 E16.42248 ; perimeter

G1 X24.568 Y83.735 E0.79926  ; perimeter
G1 X25.633 Y83.735 E0.09574  ; perimeter
G1 X25.633 Y90.837 E0.63847  ; perimeter
G1 X206.078 Y90.837 E16.22201 ; perimeter
G1 X206.078 Y83.735 E0.63847 ; perimeter
G1 X207.143 Y83.735 E0.09574 ; perimeter


G1 X207.143 Y92.457 Z3.880 E0.78431 ; move to next layer (18)
G1 X24.468 Y92.457 E16.42248 ; perimeter

G1 X24.568 Y83.735 E0.78416  ; perimeter
G1 X25.633 Y83.735 E0.09574  ; perimeter
G1 X25.633 Y90.837 E0.63847  ; perimeter
G1 X206.078 Y90.837 E16.22201 ; perimeter
G1 X206.078 Y83.735 E0.63847 ; perimeter
G1 X207.143 Y83.735 E0.09574 ; perimeter


G1 X207.143 Y92.289 Z4.080 E0.76921; move to next layer (19)
G1 X24.468 Y92.289 E16.42248 ; perimeter

G1 X24.568 Y83.735 E0.76906  ; perimeter
G1 X25.633 Y83.735 E0.09574  ; perimeter
G1 X25.633 Y90.837 E0.63847  ; perimeter
G1 X206.078 Y90.837 E16.22201 ; perimeter
G1 X206.078 Y83.735 E0.63847 ; perimeter
G1 X207.143 Y83.735 E0.09574 ; perimeter


G1 X207.143 Y92.121 Z4.280 E0.75412 ; move to next layer (20)
G1 X24.468 Y92.121 E16.42248 ; perimeter

G1 X24.568 Y83.735 E0.75395  ; perimeter
G1 X25.633 Y83.735 E0.09574  ; perimeter
G1 X25.633 Y90.837 E0.63847  ; perimeter
G1 X206.078 Y90.837 E16.22201 ; perimeter
G1 X206.078 Y83.735 E0.63847 ; perimeter
G1 X207.143 Y83.735 E0.09574 ; perimeter


G1 X207.143 Y91.954 Z4.480 E0.73911 ; move to next layer (21)
G1 X24.468 Y91.954 E16.42248 ; perimeter

G1 X24.568 Y83.735 E0.73894  ; perimeter
G1 X25.633 Y83.735 E0.09574  ; perimeter
G1 X25.633 Y90.837 E0.63847  ; perimeter
G1 X206.078 Y90.837 E16.22201 ; perimeter
G1 X206.078 Y83.735 E0.63847 ; perimeter
G1 X207.143 Y83.735 E0.09574 ; perimeter


G1 X207.143 Y91.786 Z4.680 E0.08701; move to next layer (22)
G1 X24.468 Y91.786 E16.43624 ; perimeter

G1 X24.568 Y83.735 E0.82946  ; perimeter
G1 X25.633 Y83.735 E0.09574  ; perimeter
G1 X25.633 Y90.837 E0.63846  ; perimeter
G1 X206.078 Y90.837 E16.2220 ; perimeter
G1 X206.078 Y83.735 E0.63846 ; perimeter
G1 X207.143 Y83.735 E0.09574 ; perimeter


G1 X207.143 Y91.618 Z4.880 E0.07191 ; move to next layer (23)
G1 X24.468 Y91.618 E16.43624 ; perimeter

G1 X24.568 Y83.735 E0.82946  ; perimeter
G1 X25.633 Y83.735 E0.09574  ; perimeter
G1 X25.633 Y90.837 E0.63846  ; perimeter
G1 X206.078 Y90.837 E16.2220 ; perimeter
G1 X206.078 Y83.735 E0.63846 ; perimeter
G1 X207.143 Y83.735 E0.09574 ; perimeter


G1 X207.143 Y91.450 Z5.080 E0.05681 ; move to next layer (24)
G1 X24.468 Y91.450 E16.43624 ; perimeter

G1 X24.568 Y83.735 E0.82946  ; perimeter
G1 X25.633 Y83.735 E0.09574  ; perimeter
G1 X25.633 Y90.837 E0.63846  ; perimeter
G1 X206.078 Y90.837 E16.2220 ; perimeter
G1 X206.078 Y83.735 E0.63846 ; perimeter
G1 X207.143 Y83.735 E0.09574 ; perimeter


G1 X207.143 Y91.450 E0.04171 ; perimeter

G1 X180 Y91.450 E-15; move inwards before travel
G1 X140 Y91.450 Z15; move inwards before travel


'''

parsed_gcode = parse_gcode(gcode)
# print(parsed_gcode)
# print_volumetric_info(parsed_gcode, 0.0899)

recalc_e(parsed_gcode, 0.0899)


